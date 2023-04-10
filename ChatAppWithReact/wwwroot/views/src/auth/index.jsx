import React from "react";
import { Route } from "react-router-dom";
import LoginPage from "../pages/login";

export default function hasRole(Page, path) {
    const name = sessionStorage.getItem("auth")
    return (
        name ? 
        <Route path={path} element={<Page />} /> : 
        <Route path="/login" element={<LoginPage />} />
        )
}