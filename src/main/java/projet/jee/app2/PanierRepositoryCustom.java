package projet.jee.app2;

import java.util.List;

public interface PanierRepositoryCustom {
	List<Panier> findAllByLocalisation(String localisation);
}
