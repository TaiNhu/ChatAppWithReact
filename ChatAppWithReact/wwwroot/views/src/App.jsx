import { Routes, Route, Navigate } from "react-router-dom";
import "./App.css";
import LoginPage from "./pages/login";
import hasRole from "./auth";
import HomePage from "./pages/home";
import { useState } from "react";

function App() {

	const [rerender, setRerender] = useState()

	return (
		<>
			<Routes>
				{hasRole(HomePage, "/home")}
				<Route path="/login" index element={<LoginPage customEvent={setRerender} />} />
				<Route path="*" element={<Navigate to="/login" />} /> 
			</Routes>
		</>
	);
}

export default App;
