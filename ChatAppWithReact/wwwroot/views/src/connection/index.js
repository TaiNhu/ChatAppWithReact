import * as signalR from "@microsoft/signalr"
const connection = new signalR.HubConnectionBuilder().withUrl("/chat").build();
var isConnected = false

const setConnected = (value) => {
    isConnected = value
}

export {connection, isConnected, setConnected}