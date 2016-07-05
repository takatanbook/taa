package jp.ac.asojuku.jousisenb.speechmemo;

import android.content.Intent;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import java.lang.reflect.Array;
import java.util.ArrayList;


public class SpechActivity extends ActionBarActivity {
    private SpeechRecognizer sr;
    //音声認識を開始する
    protected  void startListening(){
        try{
            if(sr == null){
                sr = SpeechRecognizer.createSpeechRecognizer(this);
                if(!SpeechRecognizer.isRecognitionAvailable(getApplicationContext())){
                    Toast.makeText(getApplicationContext(), "音声認識が使えません",
                            Toast.LENGTH_LONG).show();
                    finish();
                }
                sr.setRecognitionListener(new listener());
            }
            //インテントの作成
            Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
            //言語モデル指定
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                    RecognizerIntent.LANGUAGE_MODEL_WEB_SEARCH);
            sr.startListening(intent);
        }catch(Exception e){
            Toast.makeText(getApplicationContext(),"sartListening()でエラーが怒りました",
                    Toast.LENGTH_LONG).show();
        }
    }
    //音声認識を終了する
    protected void stopListening(){
        if(sr != null) sr.destroy();
        sr = null;
    }
    //音声認識を再開する
    public void restartListeningService(){
        stopListening();
        startListening();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_spech);
    }
    @Override
    protected void onResume(){
        super.onResume();
        startListening();
    }
    @Override
    public void onPause(){
        startListening();
        super.onPause();
    }
    // RecognitionListenerの定義
    // 中が空でも全てのメソッドを書く必要がある
    class listener implements RecognitionListener {
        public void onBeginningOfSpeech(){

        }
        //サウンドレベルが変わったときに呼ばれる
        //ただし呼ばれる補償なし
        @Override
        public void onRmsChanged(float rmsdB) {

        }

        /// 結果に対する反応などで追加の音声が来たとき呼ばれる
        // しかし呼ばれる保証はないらしい
        public void onBufferReceived(byte[] buffer){

        }
        //話し終わった時に呼ばれる
        public void onEndOfSpeech(){

        }
        //ネットワークか認識エラーが起きた時に呼ばれる
        public void onError(int error){
            String reason = "";
            switch (error) {
                //Audio recoding error
                case SpeechRecognizer.ERROR_AUDIO:
                    reason = "ERROR_AUDIO";
                    break;
                //Other client side errors
                case SpeechRecognizer.ERROR_CLIENT:
                    reason = "ERROR_CLIENT";
                    break;
                //Insufficient permissions
                case SpeechRecognizer.ERROR_NETWORK:
                    reason = "ERROR_NETWORD";
                    /*ネットワーク接続をチェックする処理ここに配置*/
                    break;
                case SpeechRecognizer.ERROR_NETWORK_TIMEOUT:
                    reason = "ERROR_NETWORK_TIMEOUT";
                    break;
                case SpeechRecognizer.ERROR_NO_MATCH:
                    reason = "ERROR_NO_MATCH";
                    break;
                //RecognitionService busy
                case SpeechRecognizer.ERROR_RECOGNIZER_BUSY:
                    reason = "ERROR_RECOGNIZER_BUSY";
                    break;
                // Server sends error status
                case SpeechRecognizer.ERROR_SERVER:
                    reason = "ERROR_SERVER";
                    //ネットワーク接続をチェックする処理ここに配置
                    break;
                //No speech input
                case SpeechRecognizer.ERROR_SPEECH_TIMEOUT:
                    reason = "ERROR_SPEECH_TIMEOUT";
                    break;
            }
            Toast.makeText(getApplicationContext(),reason,Toast.LENGTH_SHORT).show();
            restartListeningService();


        }
        //将来の使用の為に予約されている
        public void onEvent(int eventType,Bundle params){

        }
        //部分的な認識結果が利用出来るときに呼ばれる
        //部分的な認識結果が利用出来るときに呼ばれる
        public void onPartialResults(Bundle partialResults){

        }
        //音声認識の準備ができた時に呼ばれる
        public void onReadyForSpeech(Bundle params){
            Toast.makeText(getApplicationContext(),"話して下さい",
                    Toast.LENGTH_SHORT).show();
        }
        //認識結果が準備出来た時に呼ばれる
        public void onResults(Bundle results){
            //結果をArrayListとして取得
            ArrayList results_array = results.getStringArrayList(
                    SpeechRecognizer.RESULTS_RECOGNITION);
            //取得した文字列を結合

            String resultsString = "";
            for (int i = 0; i < results.size(); i++){
                resultsString += results_array.get(i) + ":";
            }
            //トーストを使って結果を表示
            Toast.makeText(getApplicationContext(),resultsString,Toast.LENGTH_LONG).show();
            restartListeningService();


        }

    }
}
