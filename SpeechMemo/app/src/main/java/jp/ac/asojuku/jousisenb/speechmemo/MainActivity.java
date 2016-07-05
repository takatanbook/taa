package jp.ac.asojuku.jousisenb.speechmemo;

import android.content.ContentValues;
import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

import java.util.List;

import jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto.MemoDto;
import jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto.MemoResultDto;
import jp.ac.asojuku.jousisenb.speechmemo.model.Modeldb;


public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btn = (Button)findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                run();

            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        Button button = (Button)findViewById(R.id.button2);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this,SpechActivity.class);
                startActivity(intent);
            }
        });
    }

    public void run(){
        Modeldb help = new Modeldb(getApplicationContext());
        Modeldb modeldb = new Modeldb(getApplicationContext());
        SQLiteDatabase db = help.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("memo","こんいちは");
        values.put("date_time","2016/06/14-10:19");
        long id = db.insert("speechMemo",null,values);
        Intent intent = new Intent(MainActivity.this,TestActivity.class);

        if (id < 0){
            intent.putExtra("message","不正成功");
        }else {
            MemoResultDto dto =  modeldb.searchByAge(db);
            List<MemoDto> list = dto.getMemolist();
            String [] memo1 = new String[250];
            int [] memoid = new int[250];
            String[] memo_date = new String[250];
            int count = 0;
            for(MemoDto data : list){
                memo1[count] = data.getMemo();
                memoid[count] = data.getMemoId();
                memo_date[count] = data.getDate_time();
                count++;
            }
            intent.putExtra("memo",memo1);
            intent.putExtra("memoId",memoid);
            intent.putExtra("memodate",memo_date);
            intent.putExtra("memoCount",count);
            intent.putExtra("message", "成功");
        }
        startActivity(intent);



    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
