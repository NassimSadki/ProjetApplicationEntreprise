package projet.jee.app2;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CategorieCommercantRepository extends JpaRepository<CategorieCommercant, Long> {
	CategorieCommercant findByCategorie(String categorie);
	List<CategorieCommercant> findAll();
}
