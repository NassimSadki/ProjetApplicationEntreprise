package projet.jee.app2;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AdminController {

	@Autowired
	private CommercantRepository commercantRepository;

	@Autowired
	private CategorieCommercantRepository categorieCommercantRepository;
	
	@Autowired
	private PanierRepository panierRepository;
	
	@Autowired
	private CategoriePanierRepository categoriePanierRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private ReservationRepository reservationRepository;

	@GetMapping("/admin")
	public String admin(Model model) {
		model.addAttribute("listeCommercant", commercantRepository.findAll());
		model.addAttribute("categorieCommercant", categorieCommercantRepository.findAll());
		model.addAttribute("ajouterCommercant", new AjouterCommercant());
		model.addAttribute("listePanier", panierRepository.findAll());
		model.addAttribute("categoriePanier", categoriePanierRepository.findAll());
		model.addAttribute("ajouterPanier", new AjouterPanier());

		return "admin";
	}

	@PostMapping("/admin/ajouter/commercant")
	public String ajouterCommercant(@ModelAttribute AjouterCommercant ajouterCommercant, Model model) {
		CategorieCommercant categorieCommercant = categorieCommercantRepository
				.findByCategorie(ajouterCommercant.getCategorie());
		Commercant commercant = new Commercant(ajouterCommercant.getNom(), categorieCommercant,
				ajouterCommercant.getLocalisation());
		commercantRepository.save(commercant);
		model.addAttribute("ajouterCommercant", ajouterCommercant);

		return "redirect:/admin";
	}

	@GetMapping("/admin/supprimer/commercant/{id}")
	public String supprimerCommercant(@PathVariable("id") long id, Model model) {
		Commercant commercant = commercantRepository.getById(id);
		List<Panier> liste = panierRepository.findAllByCommercant(commercant);
		for(int i=0; i<liste.size(); i++) {
			// supprimer les réservations des paniers proposés par le commercant
			reservationRepository.deleteByPanier(liste.get(i));
		}
		// supprimer les paniers proposés par le commercant
		panierRepository.deleteByCommercant(commercant);
		// supprimer le commercant
		commercantRepository.deleteById(id);
		
		return "redirect:/admin";
	}
	
	@PostMapping("/admin/ajouter/panier")
	public String ajouterPanier(@ModelAttribute AjouterPanier ajouterPanier, Model model) {
		CategoriePanier categoriePanier = categoriePanierRepository
				.findByCategorie(ajouterPanier.getCategorie());
		Commercant commercant = commercantRepository.findByNom(ajouterPanier.getCommercant());
		Panier panier = new Panier(categoriePanier, ajouterPanier.getNom(), ajouterPanier.getDescription(),commercant,ajouterPanier.getPrix());
		panierRepository.save(panier);
		model.addAttribute("ajouterPanier", ajouterPanier);

		return "redirect:/admin";
	}
	
	@GetMapping("/admin/supprimer/panier/{id}")
	public String supprimerPanier(@PathVariable("id") long id, Model model) {
		panierRepository.deleteById(id);

		return "redirect:/admin";
	}
	
	@GetMapping({"/admin/stats"})
	public String statistiques(Model model) {
		model.addAttribute("nombreCommercant", commercantRepository.count());
		model.addAttribute("nombreUser", userRepository.count());
		model.addAttribute("nombrePanier",panierRepository.count());
		model.addAttribute("nombrePanierReserve",reservationRepository.count());
		
		return "stats";
	}

}
