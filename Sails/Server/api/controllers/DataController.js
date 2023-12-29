
// File Must COntain Controller in Name.....
module.exports = {
    // We Finished GET REST API>...
    getUsers: async (req,res)=>{
        // going to fetch Users....

        var users = await User.find();

        res.send(users);
    },

    // POST....

    createUser: async (req,res)=>{
        
        // Getting Parameters as header....

        var header = req.headers;
        var username = header['username'];
        var password = header['password'];

        // Creating User....

       await User.create({username: username,password: password}).exec((err)=>{

            // exec <=> Completion Handler

            // returning string status...

            if(err != null){return res.send("FAIL")}
            res.send("PASS");
        });
    },

    // DELETE REST API...

    deleteUser: async (req,res)=>{
        
        var id = req.headers['id'];

        await User.destroy({id: id}).exec((err)=>{
            if(err != null){return res.send("FAIL")}
            res.send("PASS");
        })
    }
}

// Going to create DB Model.....
// To Avoid Not Defined Error....
// Define it for globally...

// We cant test Post Method In Chrome So we Need Post Man
// But I will Demostrate through Xcode SwiftUI...