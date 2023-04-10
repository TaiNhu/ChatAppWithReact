import React, { useRef, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSignOut, faPlus } from "@fortawesome/free-solid-svg-icons";
import avatar from "../../assets/avatar.png";
import "./index.css";
import instance from "../../api/instance";

export default function Header({popUpHandler}) {

	const name = sessionStorage.getItem("auth")

	const navigate = useNavigate()

	const signOutHandler = () => {
		instance.get("auth/logout")
		.then(response => {
			navigate("/login")	
			sessionStorage.clear()
		})
	}


	return (
		<nav>
			<ul>
				<li>
					<Link to="/home">
						<img src={avatar} width="80%" height="80%" />
					</Link>
					<div className="pointer"></div>
					<div className="toolbox">{name}</div>
				</li>
				<li id="add-action" onClick={() => popUpHandler(true)}>
					<FontAwesomeIcon icon={faPlus} />	
					<div className="pointer"></div>
					<div className="toolbox">Summon companion</div>
				</li>
				<li onClick={signOutHandler} id="signout-action">
					<Link>
						<FontAwesomeIcon icon={faSignOut} />
					</Link>
					<div className="pointer"></div>
					<div className="toolbox">Sign Out</div>
				</li>
			</ul>
		</nav>
	);
}
