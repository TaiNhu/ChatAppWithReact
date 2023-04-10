import React, { useEffect, useRef } from "react";
import ReactScrollableFeed from "react-scrollable-feed";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
	faPlusCircle,
	faPaperPlane,
	faAddressCard,
} from "@fortawesome/free-solid-svg-icons";
import Message from "../message";
import "./index.css";

export default function Conversation({ data, sendMessageHandler }) {
	const messageContainer = useRef();
	const inputMessage = useRef();
	const fileMessage = useRef();


	let name = "";
	let messages = [];

	if (data?.members) {
		name = data.members?.find((v) => {
			return v.memberId !== sessionStorage.getItem("auth");
		});
		if (name) {
			name = name.memberId;
		}
	}

	if (data?.messages) {
		messages = data.messages.map((v) => <Message {...v} />);
	}

	return (
		<div id="home">
			<div id="home-header">
				<FontAwesomeIcon icon={faAddressCard} />
				{name || ""}
			</div>
			<div id="home-body" ref={messageContainer}>
				<ReactScrollableFeed>{messages}</ReactScrollableFeed>
			</div>
			<div id="home-footer">
				<div className="upload-holder">
					<label htmlFor="upload">
						<FontAwesomeIcon icon={faPlusCircle} />
					</label>
					<input
						type="file"
						name="upload"
						id="upload"
						ref={fileMessage}
						onChange={(e) => {
							inputMessage.current.value = e.target.files[0].name;
						}}
					/>
				</div>
				<div className="chat-holder">
					<input
						type="text"
						name="chat"
						ref={inputMessage}
						placeholder={`Message @${name || ""}`}
					/>
				</div>
				<div className="send-holder">
					<button onClick={() => sendMessageHandler(inputMessage.current, fileMessage.current)}>
						<FontAwesomeIcon icon={faPaperPlane} />
					</button>
				</div>
			</div>
		</div>
	);
}
