package projet.jee.app2;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "commercant")
public class Commercant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String nom;

	@OneToOne
	private CategorieCommercant categorieCommercant;

	private String localisation;

	public Commercant(String nom, CategorieCommercant categorieCommercant, String localisation) {
		this.nom = nom;
		this.categorieCommercant = categorieCommercant;
		this.localisation = localisation;
	}
	
	public Commercant() {
		
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public CategorieCommercant getCategorieCommercant() {
		return categorieCommercant;
	}

	public void setCategorieCommercant(CategorieCommercant categorieCommercant) {
		this.categorieCommercant = categorieCommercant;
	}

	public String getLocalisation() {
		return localisation;
	}

	public void setLocalisation(String localisation) {
		this.localisation = localisation;
	}

}
