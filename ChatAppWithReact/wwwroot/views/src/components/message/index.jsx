import React, { useState } from "react";
import { useEffect, useRef } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSmile, faFrown, faMeh } from "@fortawesome/free-solid-svg-icons";
import JSZip from "jszip";
import { saveAs } from "file-saver";
import "./index.css";
import { connection, isConnected } from "../../connection";

export default function Message({ content, owner, typeId }) {
	let element = null;
	const imageElement = useRef();
	const [processDownload, setProcessDownload] = useState({
		process: 0,
		data: null,
		isCompleted: false,
	});

	content = content?.split(/(\:\)|\:\(|\:\|)/).map((v, i) => {
		if (i % 2 == 0) {
			return v;
		} else {
			let icon = null;
			if (v == ":)") icon = faSmile;
			else if (v == ":(") icon = faFrown;
			else if (v == ":|") icon = faMeh;
			return <FontAwesomeIcon icon={icon} />;
		}
	});

	const downloadHandler = (e) => {
		e.preventDefault();
		if (isConnected) {
			const aTag = document.createElement("a");
			if (!processDownload.isCompleted) {
				let data = "";
				connection.stream("Download", content[0], 0).subscribe({
					next: (item) => {
						data += item.data;
						setProcessDownload({
							...item,
							isCompleted: false,
						});
					},
					complete: () => {
						aTag.href =
							"data:application/" +
							content[0].match(/\.(.*)$/)[1] +
							";base64," +
							data;
						aTag.download = content[0];
						aTag.click();
						setProcessDownload({
							process: 100,
							data: data,
							isCompleted: true,
						});
					},
					error: (err) => console.log(err),
				});
			} else if (processDownload.isCompleted) {
				aTag.href = processDownload.data;
				aTag.download = content;
				aTag.click();
			}
		}
	};

	if (owner == sessionStorage.getItem("auth")) {
		element = (
			<>
				<div className="message-content">
					{typeId == 2 ? (
						<a href="#" onClick={downloadHandler}>
							{content}
						</a>
					) : (
						content
					)}
					{typeId == 2 && (
						<>
							<img
								ref={imageElement}
								src="file.png"
								width="50%"
								style={{
									margin: "auto",
									display: "block",
									paddingBlockStart: "15px",
									objectFit: "cover",
								}}
							/>
							{!processDownload.isCompleted && (
								<span
									style={{
										width: `${Math.round(processDownload?.process)}%`,
										height: "4px",
										display: "block",
										backgroundColor: "black",
										borderRadius: "2px",
									}}
								></span>
							)}
						</>
					)}
				</div>
				<div className="message-avatar">{owner}</div>
			</>
		);
	} else {
		element = (
			<>
				<div className="message-avatar">{owner}</div>
				<div className="message-content">
					{typeId == 2 ? (
						<a href="#" onClick={downloadHandler}>
							{content}
						</a>
					) : (
						content
					)}
					{typeId == 2 && (
						<>
							<img
								ref={imageElement}
								loop={true}
								src="file.png"
								width="50%"
								style={{
									margin: "auto",
									display: "block",
									paddingBlockStart: "15px",
									objectFit: "cover",
								}}
							/>
							{!processDownload.isCompleted && (
								<span
									style={{
										width: `${Math.round(processDownload?.process)}%`,
										height: "4px",
										display: "block",
										backgroundColor: "black",
										borderRadius: "2px",
									}}
								></span>
							)}
						</>
					)}
				</div>
			</>
		);
	}

	useEffect(() => {
		if (typeId === 2 && /\.(png|jpg|gif|jpeg|svg)$/.test(content[0])) {
			if (isConnected) {
				let imageSrc = "";
				connection.stream("Download", content[0], 0).subscribe({
					next: (item) => {
						imageSrc += item.data;
						setProcessDownload({ ...item, isCompleted: false });
					},
					complete: () => {
						imageElement.current.src =
							"data:image/" +
							content[0].match(/\.(.*)$/)[1] +
							";base64," +
							imageSrc;
						setProcessDownload({
							process: 100,
							data: imageElement.current.src,
							isCompleted: true,
						});
					},
					error: (err) => console.log(err),
				});
			}
		}
	}, []);

	return <div className="message-holder">{element}</div>;
}
