package jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto;

/**
 * Created by takamichi on 2016/06/17.
 */
public class MemoDto {
    private int memoId;
    private String memo;
    private String date_time;

    public int getMemoId() {
        return memoId;
    }
    public void setMemoId(int memoId) {
        this.memoId = memoId;
    }
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }
    public String getDate_time() {
        return date_time;
    }
    public void setDate_time(String date_time) {
        this.date_time = date_time;
    }
}
