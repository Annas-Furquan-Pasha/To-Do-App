import 'package:flutter/material.dart';
import 'package:to_do/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Widget card(task)
  {
    return Card(
      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              task.task,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'due date: ${task.date}',
              style: const TextStyle(
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'due time: ${task.time}',
              style: const TextStyle(
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: task.value,
                      onChanged: (value) {
                        setState(() {
                          task.value = value!;
                          if(task.value == true) {
                            task.status = 'completed!!!';
                          } else {
                            task.status = 'pending......';

                          }
                        });
                      },
                    ),
                    Text(task.status)
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    tasks.remove(task);
                    saveTask();
                    setState(() {

                    });
                  },
                  label: const Text('delete'),
                  icon : const Icon(Icons.delete),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveTask() async
  {
    final preferences = await SharedPreferences.getInstance();
    for(int i=0; i<tasks.length; i++)
      {
        await preferences.setString('task$i', tasks[i].task);
        await preferences.setString('time$i', tasks[i].time);
        await preferences.setString('date$i', tasks[i].date);
        await preferences.setString('status$i', tasks[i].status);
        await preferences.setBool('value$i', tasks[i].value);
      }
    await preferences.setInt('i', tasks.length);
  }

  void getTask() async
  {
    final preferences = await SharedPreferences.getInstance();
    int? i = preferences.getInt('i');
    for(int j=0; j<i!; j++) {
      var task =  preferences.getString('task$j');
      var date = preferences.getString('date$j');
      var time = preferences.getString('time$j');
      var status = preferences.getString('status$j');
      var value = preferences.getBool('value$j');
      setState(() {
        tasks.add(Task(task!, date!, time!, status!, value!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('To Do',
          style: TextStyle(
            fontSize: 30.0,
            //color: Colors.white54,
          ),
        ),
        //backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: tasks.isEmpty
            ? Center(
            child : Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height*(1/4)),
                    SizedBox(
                      height: 100.0,
                        width: 100.0,
                        child:  Image.asset('assets/images/question.jpg',),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     Text(
                      'Its lonely here !!',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
      )
         : Column(
          children: tasks.map((tak) => card(tak)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic tak = await Navigator.pushNamed(context, '/second');
          tasks.add(tak);
          saveTask();
          setState(() {

          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

