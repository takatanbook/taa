package jp.ac.asojuku.jousisenb.speechmemo.jp.ac.asojuku.jousisenb.speechmemo.dto;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by takamichi on 2016/06/17.
 */
public class MemoResultDto {
    private List<MemoDto> memolist;
    public List<MemoDto> getMemolist()
    {
        return memolist;
    }

    public void setMemolist(List<MemoDto> memolist)
    {
        this.memolist = memolist;
    }
    public void add(MemoDto memolist)
    {
        if (this.memolist == null)
        {
            this.memolist = new ArrayList<MemoDto>();
        }
        this.memolist.add(memolist);
    }
}
