import React from "react";
import "./index.css";

export default function Room({ room, lastMessage, members, customClick }) {
	const name = members.findIndex((v) => {
		return v.memberId !== sessionStorage.getItem("auth");
	});

	return (
		<div className={`room ${room?.isFocus || ""}`} onClick={() => customClick(room.id)}>
			<div className="avatar-holder">{members[name].memberId}</div>
			<div className="message">{lastMessage}</div>
		</div>
	);
}
