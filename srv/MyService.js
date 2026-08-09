//Implementation file - js with same name
//DPC_EXT class you write in ABAP for Service implementation
const cds = require('@sap/cds')

//Custom Handler class 'MyService'
module.exports = class MyService extends cds.ApplicationService { init() {
//async (req) => { ... } the handler function. 'req' is the request object in CAP
  this.on ('ramdas', async (req) => {
    // console.log('On ramdas', req.data)
    let myName = req.data.name;    

    return `Welcome to CAP Server, Hello ${myName}!! How are you today 🤔`
  })

  //Calling parent class init() method
  return super.init() 
}}

//Execution:
// https://port4004-workspaces-ws-i2nxr.us10.trial.applicationstudio.cloud.sap/odata/v4/MyService/ramdas(name='IRONMANE')