import 'package:flutter/material.dart';
import 'task.dart';
//import 'package:to_do/home.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => AddState();
}

class AddState extends State<Add> {

  String _task = '';
  String _date  = '';
  String _time = '';
  String errorD = '';
  String errorT = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: 'Task',
                    errorText: errorT,
                    
                  ),
                  onChanged: (t) {_task = t;
                    if(_task == '')
                      {
                        errorT = 'enter task';
                      }
                    },
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.0,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.blue,
                        ),
                      ),
                      child: Text(
                        _date,
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                         DateTime? tem = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030));
                          setState((){
                            _date = '${tem?.day} - ${tem?.month} - ${tem?.year}';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 5.0,
                        ),
                        child: const Text('Select Date',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.0,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.blue,
                        ),
                      ),
                      child: Text(
                        _time,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                       TimeOfDay? tem = await showTimePicker(
                           context: context,
                           initialTime: TimeOfDay.now(),);
                       String h = '00';
                       String a = 'AM';
                       if(tem != null){

                         if(tem.hour > 12) {
                           h = (tem.hour - 12).toString();
                           a = 'PM';
                         }
                         else {
                           h = (tem.hour).toString();
                         }
                         if(h== '0'){
                           h = '12';
                           a ='AM';
                         }
                         else if(h == '12'){
                           a = 'PM';
                         }
                       }
                       setState(() {
                         _time = '$h:${tem?.minute} $a';
                       });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 5.0,
                      ),
                      child: const Text('Select Time',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context,Task( _task,  _date, _time, 'Pending....', false));
                        });
                      },
                      child: const Text('Done',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
