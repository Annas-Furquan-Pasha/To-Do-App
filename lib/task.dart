class Task
{
    late String task;
    late String date;
    late String time;
    bool value = false;
    String status = 'Pending.....';
    Task.empty() ;
    Task(String t , String d, String ti, String s, bool v)
    {
        task = t;
        date = d;
        time = ti;
        status = s;
        value = v;
    }
}

List<Task> tasks = [];