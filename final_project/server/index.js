console.log("Hello,World");

const express=require("express");
const mongoose=require("mongoose");

const authRouter=require("./routes/auth");

const PORT=3000;
const app=express();
const DB="mongodb+srv://mukarramali623:sTvrX7wRalouZfF9@cluster0.b0lgca8.mongodb.net/?retryWrites=true&w=majority";

//middleware
// client -> middleware -> server -> client
app.use(express.json());
app.use(authRouter);

// conections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});


app.listen(PORT, () => {
    console.log(`Connected at port ${PORT}`);
});