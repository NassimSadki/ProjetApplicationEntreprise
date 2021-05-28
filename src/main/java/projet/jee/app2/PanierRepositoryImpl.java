package projet.jee.app2;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class PanierRepositoryImpl implements PanierRepositoryCustom {

	@Autowired
    private PanierRepository panierRepository;
	
	@Override
	public List<Panier> findAllByLocalisation(String localisation) {
		ArrayList<Panier> panierByLocalisation = new ArrayList<Panier>();
		List<Panier> allPanier = panierRepository.findAll();
		for(int i=0; i<allPanier.size(); i++) {
			if(allPanier.get(i).getCommercant().getLocalisation().equals(localisation)) {
				panierByLocalisation.add(allPanier.get(i));
			}
		}
		return panierByLocalisation;
	}
}
