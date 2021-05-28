package projet.jee.app2;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriePanierRepository extends JpaRepository<CategoriePanier, Long> {
	CategoriePanier findByCategorie(String categorie);
	List<CategoriePanier> findAll();
}
