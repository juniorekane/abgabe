package hbv.web;
import jakarta.websocket.*;
import jakarta.websocket.server.*;
import java.io.*;

import hbv.service.*;

@ServerEndpoint("/websocket")
public class HelloEndpoint{

  @OnOpen
  public void onOpen(Session session){
  }

  @OnClose
  public void onClose(Session session) {
    try{
      session.close();
    }catch(Exception e){
      MyLogger.info(""+e);
    }
  }
  @OnError
  public void onError(Session session, Throwable thr){
    MyLogger.info("websocket error");
  }
  @OnMessage
  public void onMessage(String msg, Session session) throws IOException{
      if (session.isOpen()) {
        session.getBasicRemote().sendText("got:"+msg);
      }

  }
}


