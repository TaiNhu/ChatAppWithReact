const connection = new signalR.HubConnectionBuilder().withUrl("/chat").build()

const signIn = (name, isRemember) => {
    axios.post("http://localhost:5264/auth/login", {
        Id: name,
        isRemmember: isRemember
    }).then(response => {
        console.log(response)
    }).catch(err => {
        console.log(err)
    })
}


connection.on("ReceivedMessage", (message) => {
    console.log(message)
})

connection.start()
    .then(data => {
        
    })
    .catch(err => {
        console.log(err)
    })

const sendData = (content, owner) => {
    connection.send("ReceivedMessage", {
        Content: content,
        TypeId: 1,
        RoomId: "03b679a0-3447-4529-80ac-48d6f1899646",
        Owner: owner
    })
}

const joinConversation = (roomId) => {
    connection.send("JoinGroup", roomId)
}
