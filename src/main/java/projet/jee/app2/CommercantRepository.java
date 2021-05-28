package projet.jee.app2;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CommercantRepository extends JpaRepository<Commercant, Long> {
	Commercant findByNom(String nom);
	List<Commercant> findAllByCategorieCommercant(CategorieCommercant categorieCommercant);
	List<Commercant> findAllByLocalisation(String localisation);
	List<Commercant> findAll();
}
