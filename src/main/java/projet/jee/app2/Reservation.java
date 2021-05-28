package projet.jee.app2;

import javax.persistence.*;

@Entity
@Table(name = "reservation")
public class Reservation {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@OneToOne
	private User user;
	
	@OneToOne
	private Panier panier;
	
	private String dateTime;

	public Reservation(Long id, User user, Panier panier, String dateTime) {
		super();
		this.id = id;
		this.user = user;
		this.panier = panier;
		this.dateTime = dateTime;
	}
	
	public Reservation(User user, Panier panier, String dateTime) {
		super();
		this.user = user;
		this.panier = panier;
		this.dateTime = dateTime;
	}
	
	public Reservation() {
		
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Panier getPanier() {
		return panier;
	}

	public void setPanier(Panier panier) {
		this.panier = panier;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	
}
