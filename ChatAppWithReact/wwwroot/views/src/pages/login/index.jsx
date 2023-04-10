import "react"
import { useEffect, useRef, useState } from "react"
import { useNavigate } from "react-router-dom"
import "./index.css"
import instance from "../../api/instance"

const LoginPage = ({customEvent}) => {

    const userName = useRef()
    const buttonSignIn = useRef()
    const [err, setErr] = useState("Maximum 10 char")
    const navigate = useNavigate()

    const signInHanlder = () => {
        buttonSignIn.current.disabled = true 
        instance.post("auth/login", {
            "Id": userName.current.value,
            "isRemmember": false
        }).then(response => {
            console.log(response)
            sessionStorage.setItem("auth", userName.current.value)
            customEvent("")
            navigate("/home")
        }).catch(err => {
            buttonSignIn.current.disabled = false
            setErr(err.message)
        })
    }

    return (
        <div id="login-page">
            <div id="login-panel">
                <h2 id="login-header">
                    Welcome to my chat app<br/>
                    <span style={{fontSize: 16, fontWeight: "normal"}}>Enjoy your time</span>
                </h2>
                <div id="login-form">
                    <label>YOUR COOL NAME!</label>
                    <span style={{color: "red", fontSize: 12}}>{err}</span>
                    <input type="text" ref={userName}></input>
                </div>
                <div id="login-submit">
                    <button ref={buttonSignIn} onClick={signInHanlder}>Discover your journey</button>
                </div>
            </div>
        </div>
    )
}

export default LoginPage