package beans;

import com.mongodb.*;
import java.net.UnknownHostException;

public class mconnect {

	final String HOST = "localhost";
	final int PORT=27017;
	final String DBNAME="GameSpeed";
	public static mconnect instance;
	public MongoClient connection;
	public DB database;

private mconnect() throws UnknownHostException {
	this.connection = new MongoClient(this.HOST,this.PORT);
	this.database = this.connection.getDB(DBNAME);
}

public static mconnect createInstance() throws UnknownHostException {
	if(mconnect.instance == null) {
		mconnect.instance = new mconnect();
	}
	return mconnect.instance;
}

public DBCollection getCollection(String name) {
	return this.database.getCollection(name);
}

}
