package projet.jee.app2;


public class AjouterPanier {
	
	private String categorie;
	
	private String nom;
	
	private String description;
	
	private String commercant;
	
	private float prix;

	public String getCategorie() {
		return categorie;
	}

	public void setCategorie(String categorie) {
		this.categorie = categorie;
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

	public String getCommercant() {
		return commercant;
	}

	public void setCommercant(String commercant) {
		this.commercant = commercant;
	}

	public float getPrix() {
		return prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}
	
}
