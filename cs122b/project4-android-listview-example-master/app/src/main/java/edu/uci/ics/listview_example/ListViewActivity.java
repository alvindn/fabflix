package edu.uci.ics.listview_example;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class ListViewActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_listview);

        final ArrayList<Person> people = new ArrayList<>();
        people.add(new Person("Peter Anteater", 1965));
        people.add(new Person("John Doe", 1975));

        PeopleListViewAdapter adapter = new PeopleListViewAdapter(people, this);

        ListView listView = (ListView)findViewById(R.id.list);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Person person = people.get(position);
                String message = String.format("Clicked on position: %d, name: %s, %d", position, person.getName(), person.getBirthYear());
                Toast.makeText(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
