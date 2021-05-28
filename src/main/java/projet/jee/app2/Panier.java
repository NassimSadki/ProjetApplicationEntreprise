package projet.jee.app2;

import javax.persistence.*;


@Entity
@Table(name = "panier")
public class Panier {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@OneToOne
	private CategoriePanier categoriePanier;
	
	private String nom;
	
	private String description;
	
	@OneToOne
	private Commercant commercant;
	
	private float prix;

	public Panier(CategoriePanier categoriePanier, String nom, String description, Commercant commercant,
			float prix) {
		super();
		this.categoriePanier = categoriePanier;
		this.nom = nom;
		this.description = description;
		this.commercant = commercant;
		this.prix = prix;
	}
	
	public Panier() {
		
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CategoriePanier getCategoriePanier() {
		return categoriePanier;
	}

	public void setCategoriePanier(CategoriePanier categoriePanier) {
		this.categoriePanier = categoriePanier;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Commercant getCommercant() {
		return commercant;
	}

	public void setCommercant(Commercant commercant) {
		this.commercant = commercant;
	}

	public float getPrix() {
		return prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}

}
