import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;

import com.bettinghouse.User;

public aspect Logger {
	// define register rules
	File fe = new File("Register.txt");
	
	
	pointcut success() : call(* successfulSignUp*(..));
	
	after() throws IOException : success() {
		// Crear el log y guardar en el archivo
		System.out.println("Usuario creado");
		User us = (User)(thisJoinPoint.getArgs()[0]);
		DateTimeFormatter formattime = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss yyyy");
	
		String log_register = "Usuario registrado: " + "[nickname = " + us.getNickname() + ", " + "password = " + us.getPassword() + "]" + "     " + "Fecha: [" + cal.get(0) + "]";
		System.out.println(log_register);
		escribir(log_register);
	}
	
	public void escribir(String data) throws IOException {
		
		try(BufferedWriter wf = new BufferedWriter(new FileWriter("Register.txt", true))) {
			
			wf.write(data);
			wf.write("\n");
			
			wf.close();
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
