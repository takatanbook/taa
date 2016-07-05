package jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.util;

/**
 * Created by takamichi on 2016/06/27.
 */
import java.util.Date;
import java.text.SimpleDateFormat;
public class CurrentTime {
    private static String dateformat ="yyyy/MM/dd HH:mm:ss";
    public String getcurrentTime(){
        String date = "";
        Date da = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat(dateformat);
        date = sdf1.toString();
        return date;
    }
}
