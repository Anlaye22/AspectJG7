import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.bettinghouse.User;

public aspect Log {
	pointcut successLogin() : call(* effectiveLogIn*(..));
	pointcut successLogout() : call(* effectiveLogOut*(..));
	
	public static String kloginmsg = "";
	
	after() throws IOException: successLogin() {
		User us = (User)(thisJoinPoint.getArgs()[0]);
		System.out.println(us);
		DateTimeFormatter formattime = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss yyyy");
		String mensaje = "Sesion iniciada por usuario: [" + us.getNickname() + "]  Fecha: [" + LocalDateTime.now().format(formattime) + "]"; 
		//escribir(mensaje);
		kloginmsg = mensaje;
	}
	
	after() throws IOException: successLogout() {
		User us = (User)(thisJoinPoint.getArgs()[0]);
		System.out.println(us);
		DateTimeFormatter formattime = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss yyyy");
		String mensaje = "Sesion cerrada por usuario: [" + us.getNickname() + "]  Fecha: [" + LocalDateTime.now().format(formattime) + "]"; 
		escribir(mensaje);
	}
	
	public void escribir(String data) throws IOException {
		
		try(BufferedWriter wf = new BufferedWriter(new FileWriter("Log.txt", true))) {
			
			wf.write(kloginmsg);
			wf.write("\n");
			wf.write(data);
			wf.write("\n");
			
			wf.close();
		}catch(Exception e) {
			System.out.println(e);
		}

	}
}
