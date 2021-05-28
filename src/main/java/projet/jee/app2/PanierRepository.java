package projet.jee.app2;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

public interface PanierRepository extends JpaRepository<Panier, Long>, PanierRepositoryCustom {
	Panier findByNom(String nom);
	Panier findById(long id);
	List<Panier> findAllByCommercant(Commercant commercant);
	List<Panier> findAllByCategoriePanier(CategoriePanier categoriePanier);
	List<Panier> findAll();
	@Transactional
	void deleteByCommercant(Commercant commercant);
}