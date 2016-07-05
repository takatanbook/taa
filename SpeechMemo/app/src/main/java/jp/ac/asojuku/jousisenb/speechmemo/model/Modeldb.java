package jp.ac.asojuku.jousisenb.speechmemo.model;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.List;

import jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto.MemoDto;
import jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto.MemoResultDto;

/**
 * Created by takamichi on 2016/06/13.
 */
public class Modeldb extends SQLiteOpenHelper {

    static final String DB_NAME = "sqlite_sample.db";
    static final int DB_VERSION = 1;

    static final String CREATE_TABLE = "CREATE TABLE speechMemo(memo_id integer primary key autoincrement, memo text, date_time text);";

    static final String DROP_TABLE = "drop table speechMemo;";

    public Modeldb(Context c) {
        super(c, DB_NAME, null, DB_VERSION);
    }
    private MemoResultDto resultDto = new MemoResultDto();

    /**
     * データベースファイル初回使用時に実行される処理
     */
    @Override
    public void onCreate(SQLiteDatabase db) {
        // テーブル作成のクエリを発行
        db.execSQL(CREATE_TABLE);
    }

    /**
     * データベースのバージョンアップ時に実行される処理
     */
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // テーブルの破棄と再作成
        db.execSQL(DROP_TABLE);
        onCreate(db);
    }
    /** エントリ追加 */
    private boolean doAddEntry( SQLiteDatabase db, String name, String year){
        // 挿入するデータはContentValuesに格納
        ContentValues val = new ContentValues();
        val.put("memo",name);
        val.put("date_time",year);
        long id = db.insert("speechMemo",null,val);
        if (id < 0){
            return false;
        }else{
            return true;
        }

    }
    /*

        SQLiteDatabase.query()メソッドの第一引数はテーブル名です。
        第二引数は、取得する列名(カラム名、フィールド名)の配列を指定します。
        第三引数、第四引数は取得するレコードの条件を指定します。
        今回は、bookmark列の文字列に、「android」という文言が含まれる文字列、という条件にしています。
        第五引数は、group by句を指定します。
        第六引数は、Having句を指定します。
        第七引数は、order by句を指定します。
        第八引数は、limit句(取得するレコードの上限数)を指定します。
        使わない場合は、nullを指定します。
        今回の処理をSQL文で表現すると、以下のよう

    *
    * */
    /** メモをデータを検索 */
    public MemoResultDto searchByAge( SQLiteDatabase db){
        // Cursorを確実にcloseするために、try{}～finally{}にする
        Cursor cursor = null;
        try{
            // name_book_tableからnameとageのセットを検索する
            // ageが指定の値であるものを検索
            cursor = db.query( "speechMemo",
                    new String[]{ "memo_id", "memo", "date_time" },
                    null, null,
                    null, null, null );

            // 検索結果をcursorから読み込んで返す
            resultDto = readCursor( cursor );
            return resultDto;
        }
        finally{
            // Cursorを忘れずにcloseする
            if( cursor != null ){
                cursor.close();
            }
        }
    }


    /** 検索結果の読み込み */
    private MemoResultDto readCursor( Cursor cursor ){
        String result = "";

        // まず、Cursorからmemo_idカラムとmemoカラムとdate_idカラムを
        // 取り出すためのインデクス値を確認しておく
        int indexMemoId = cursor.getColumnIndex( "memo_id" );
        int indexMemo  = cursor.getColumnIndex( "memo"  );
        int indexMemodate  = cursor.getColumnIndex( "date_time" );
        MemoDto dto = new MemoDto();

        // ↓のようにすると、検索結果の件数分だけ繰り返される
        while( cursor.moveToNext() ){
            // 検索結果をCursorから取り出す
            String memoname = cursor.getString( indexMemo  );
            int    memoid = cursor.getInt   ( indexMemoId  );
            String memodate = cursor.getString( indexMemodate  );
            dto.setMemo(memoname);
            dto.setMemoId(memoid);
            dto.setDate_time(memodate);
            resultDto.add(dto);
        }
        return resultDto;
    }
    /** idを条件に削除 */
    public int delByAge( SQLiteDatabase db, int id ){
        int i = 0;
        i = db.delete( "speechMemo",
                "memo_id = ?",
                new String[]{ "" + id } );
        return i;
    }
    /** 特定の年齢のデータを更新
     * id 条件
     * date and memo
     * */
    public void updateEntry( SQLiteDatabase db, int id, String newMemo, String newdata_time ){
        // 更新内容はContentValuesに格納しておく
        ContentValues val = new ContentValues();
        val.put( "memo", newMemo );
        val.put( "date_time" , newdata_time  );

        // 更新するデータの条件はquery()やdelete()と同じように記述する
        db.update( "speechMemo",
                val,
                "age = ?",
                new String[]{ "" + id } );
    }


}