import React, { useEffect, useRef, useState } from "react";
import * as signalR from "@microsoft/signalr";
import Header from "../../components/header";
import "./index.css";
import Room from "../../components/room";
import Conversation from "../../components/conversation";
import instance from "../../api/instance";
import { connection, isConnected, setConnected } from "../../connection";

export default function HomePage() {
	const [rooms, setRoom] = useState([]);
	const [conversation, setConversation] = useState({});
	const [err, setErr] = useState("Maximun 10 char");
	const [isPopup, setPopup] = useState(false);
	const summonContainer = useRef();
	const companionNameElement = useRef();
	const summonButton = useRef();

	useEffect(() => {
		// get room
		instance
			.get("rooms")
			.then((response) => {
				response.data.forEach((v) => {
					v.room.isFocus = false;
				});
				setRoom(response.data);
			})
			.catch((err) => {
				console.log(err);
			});

		// hub

		connection.on("ReceivedMessage", (message) => {
			console.log(message)
			setRoom((previous) => {
				previous.forEach((v) => {
					if (v.room.id == message.roomId) {
						v.lastMessage = message.content;
						v.messages.push(message);
					}
				});
				return [...previous];
			});
		});

		connection
			.start()
			.then((v) => {
				console.log("connection success");
				setConnected(true);
			})
			.catch((err) => {
				console.log(err);
			});
	}, []);

	const sendMessageHandler = (messageElement, fileMessage) => {
		if (isConnected) {
			if (!fileMessage.files[0]) {
				let room = rooms.find((v) => v.room.isFocus);
				if (room) {
					connection.send("ReceivedMessage", {
						content: messageElement.value,
						typeId: 1,
						roomId: room.room.id,
						owner: sessionStorage.getItem("auth"),
					});
					messageElement.value = "";
				}
			} else if (fileMessage.files[0]) {
				const subject = new signalR.Subject();
				const file = fileMessage.files[0];
				const reader = new FileReader();
				reader.onload = (event) => {
					const room = rooms.find((v) => v.room.isFocus);
					if (room) {
						const data = event.target.result;
						const chunkSize = 1024;
						const chunks = data.length / chunkSize;
						let count = 0;
						connection.invoke("Upload", subject);
						do {
							const value = {
								Owner: sessionStorage.getItem("auth"),
								Content: file.name,
								RoomId: room.room.id,
								DataStream: data.slice(
									count * chunkSize,
									Math.min(data.length, count * chunkSize + chunkSize)
								),
							};
							subject.next(value);
							count++;
						} while (count < chunks);
						subject.complete();
						console.log("Done");
						fileMessage.value = null
					}
				};
				reader.readAsDataURL(file);
			}
		}
	};

	const roomClickHandler = (id) => {
		setRoom((previous) =>
			previous.map((v) => {
				if (v.room.id === id) {
					return { ...v, room: { ...v.room, isFocus: true } };
				}
				return { ...v, room: { ...v.room, isFocus: false } };
			})
		);
	};

	const summonCompanionHandler = () => {
		if (
			companionNameElement.current.value.length < 1 ||
			companionNameElement.current.value.length > 10
		) {
			setErr("Name is not valid (0 < length < 10)");
		} else if (isConnected) {
			summonButton.current.disabled = true;
			connection
				.invoke("JoinGroup", null, companionNameElement.current.value)
				.then((e) => {
					summonButton.current.disabled = false;
					console.log(e);
					if (!e) {
						instance
							.get("rooms")
							.then((response) => {
								response.data.forEach((v) => {
									v.room.isFocus = false;
								});
								console.log("rooms", response.data);
								setRoom(response.data);
								setPopup(false);
							})
							.catch((err) => {
								console.log(err);
							});
					} else {
						setErr(e);
					}
				});
		}
	};

	useEffect(() => {
		setConversation(() => {
			let value = rooms.find((v) => v.room.isFocus);
			if (value) {
				return value;
			}
			return {};
		});
		if (isConnected) {
			rooms.forEach((v) => {
				const userName = v.members.find(
					(v) => v.memberId !== sessionStorage.getItem("auth")
				).memberId;
				connection.send("JoinGroup", v.room.id, userName);
			});
		}
	}, [rooms]);

	const roomComponents = rooms.map((v) => (
		<Room {...v} key={v.room.id} customClick={roomClickHandler} />
	));

	return (
		<>
			<Header popUpHandler={setPopup} />
			<div id="rooms">
				<div id="conversation-header">Conversations</div>
				{roomComponents}
			</div>
			<Conversation
				data={conversation}
				sendMessageHandler={sendMessageHandler}
			/>
			<div
				ref={summonContainer}
				className={`add-room-container ${isPopup ? "active" : ""}`}
				onClick={(e) => {
					if (e.target === summonContainer.current) {
						setPopup(false);
					}
				}}
			>
				<div className="add-room-panel">
					<h3 className="add-room-header">Summon your companion</h3>
					<div className="add-room-body">
						<label>YOUR COMPANION NAME!</label>
						<span style={{ color: "red", fontSize: 12 }}>{err}</span>
						<input type="text" ref={companionNameElement}></input>
					</div>
					<div className="add-room-footer">
						<button ref={summonButton} onClick={summonCompanionHandler}>
							Summon
						</button>
					</div>
				</div>
			</div>
		</>
	);
}
