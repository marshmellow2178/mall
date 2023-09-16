package svc;

import dao.OrderDao;

import java.util.*;
import dao.*;
import vo.*;

public class ArtistSvc {
	private ArtistDao artistDao;
	
	public ArtistSvc(ArtistDao artistDao) {
	this.artistDao = artistDao;
	}
	public List<ArtistCode> getArtistList(String o){
		List<ArtistCode> artistList = artistDao.getArtistList(o);
		return artistList;
		
	}
}
