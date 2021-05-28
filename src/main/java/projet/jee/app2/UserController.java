package projet.jee.app2;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
	
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;
    
    @Autowired
    private CategorieCommercantRepository categorieCommercantRepository;
    
    @Autowired
    private CategoriePanierRepository categoriePanierRepository;
    
    @Autowired
    private CommercantRepository commercantRepository;
    
    @Autowired
    private PanierRepository panierRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getPasswordConfirm());
      
        return "redirect:/welcome";
    }

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Nom d'utilisateur et mot de passe incorrects.");

        if (logout != null)
            model.addAttribute("message", "Vous vous êtes déconnectés avec succès.");
        
        return "login";
    }

    @GetMapping({"/", "/welcome"})
    public String welcome(Model model) {
    	model.addAttribute("filtresCommercant", new FiltresCommercant());
    	model.addAttribute("filtresPanier", new FiltresPanier());
    	model.addAttribute("formulaireReservation", new FormulaireReservation());
    	model.addAttribute("CategorieCommercant",categorieCommercantRepository.findAll());
    	model.addAttribute("CategoriePanier",categoriePanierRepository.findAll());
    	model.addAttribute("Commercant",commercantRepository.findAll());
    	model.addAttribute("Panier",panierRepository.findAll());

        return "welcome";
    }
    
    @PostMapping({"/welcome"})
    public String welcome(@ModelAttribute FiltresCommercant filtresCommercant, @ModelAttribute FiltresPanier filtresPanier, Model model) {
    	
    	if(filtresCommercant.getCategorie() != null && filtresCommercant.getLocalisationCommercant() != null) {
    		List<Commercant> listeNonFiltreeCommercant = commercantRepository.findAll();
    		List<Commercant> listeFiltreeCommercant = new ArrayList<Commercant>();
    		List<Commercant> listeFiltreeParLocalisationCommercant = null;
    		List<Commercant> listeFiltreeParCategorieCommercant = null;
    		
    		if(filtresCommercant.getLocalisationCommercant() != null && !filtresCommercant.getLocalisationCommercant().equals("N'importe")) {
    			listeFiltreeParLocalisationCommercant = commercantRepository.findAllByLocalisation(filtresCommercant.getLocalisationCommercant());
    		}
    		if(filtresCommercant.getCategorie() != null && !filtresCommercant.getCategorie().equals("N'importe")) {
    			listeFiltreeParCategorieCommercant = commercantRepository.findAllByCategorieCommercant
    					(categorieCommercantRepository.findByCategorie(filtresCommercant.getCategorie()));
    		}
    		if(filtresCommercant.getLocalisationCommercant().equals("N'importe")) {
    			listeFiltreeParLocalisationCommercant = commercantRepository.findAll();
    		}
    		if(filtresCommercant.getCategorie().equals("N'importe")) {
    			listeFiltreeParCategorieCommercant = commercantRepository.findAll();
    		}
    		if(listeFiltreeParLocalisationCommercant != null && listeFiltreeParCategorieCommercant != null) {
    			for (int i = 0; i < listeNonFiltreeCommercant.size(); i++) {
    				if(listeFiltreeParLocalisationCommercant.contains(listeNonFiltreeCommercant.get(i)) 
    						&& listeFiltreeParCategorieCommercant.contains(listeNonFiltreeCommercant.get(i)) ) {
    					listeFiltreeCommercant.add(listeNonFiltreeCommercant.get(i));
    				}
    			}
    		}
    		model.addAttribute("filtresCommercant",filtresCommercant);
    		model.addAttribute("listeFiltreeCommercant",listeFiltreeCommercant);
    	}
    	

		if(filtresPanier.getCommercant() != null && filtresPanier.getCategorie() != null 
				&& filtresPanier.getLocalisationPanier() != null) {
			List<Panier> listeNonFiltreePanier = panierRepository.findAll();
			List<Panier> listeFiltreePanier = new ArrayList<Panier>();
			List<Panier> listeFiltreeParCommercantPanier = null;
			List<Panier> listeFiltreeParCategoriePanier = null;
			List<Panier> listeFiltreeParLocalisationPanier = null;
			
			if(filtresPanier.getCommercant() != null && !filtresPanier.getCommercant().equals("N'importe")) {
				listeFiltreeParCommercantPanier = panierRepository.findAllByCommercant
						(commercantRepository.findByNom(filtresPanier.getCommercant()));
			}
			if(filtresPanier.getCategorie() != null && !filtresPanier.getCategorie().equals("N'importe")) {
				listeFiltreeParCategoriePanier = panierRepository.findAllByCategoriePanier
						(categoriePanierRepository.findByCategorie(filtresPanier.getCategorie()));
			}
			if(filtresPanier.getLocalisationPanier() != null && !filtresPanier.getLocalisationPanier().equals("N'importe")) {
				listeFiltreeParLocalisationPanier = panierRepository.findAllByLocalisation(filtresPanier.getLocalisationPanier());
			}
			if(filtresPanier.getCommercant().equals("N'importe")) {
				listeFiltreeParCommercantPanier = panierRepository.findAll();
			}
			if(filtresPanier.getCategorie().equals("N'importe")) {
				listeFiltreeParCategoriePanier = panierRepository.findAll();
			}
			if(filtresPanier.getLocalisationPanier().equals("N'importe")) {
				listeFiltreeParLocalisationPanier = panierRepository.findAll();
			}
			if(listeFiltreeParCommercantPanier != null && listeFiltreeParCategoriePanier != null 
					&& listeFiltreeParLocalisationPanier != null) {
				for (int i = 0; i < listeNonFiltreePanier.size(); i++) {
					if(listeFiltreeParCommercantPanier.contains(listeNonFiltreePanier.get(i)) 
							&& listeFiltreeParCategoriePanier.contains(listeNonFiltreePanier.get(i))
							&& listeFiltreeParLocalisationPanier.contains(listeNonFiltreePanier.get(i))) {
						listeFiltreePanier.add(listeNonFiltreePanier.get(i));
					}
				}
			}
			model.addAttribute("filtresPanier",filtresPanier);
			model.addAttribute("listeFiltreePanier",listeFiltreePanier);
		}
    	model.addAttribute("formulaireReservation", new FormulaireReservation());
		model.addAttribute("CategorieCommercant",categorieCommercantRepository.findAll());
    	model.addAttribute("CategoriePanier",categoriePanierRepository.findAll());
    	model.addAttribute("Commercant",commercantRepository.findAll());
    	model.addAttribute("Panier",panierRepository.findAll());
    	
    	return "welcome";
    }
    
    @GetMapping({"/reserver/{id}"})
    public String reserver(@PathVariable("id") long id, Model model) {
    	LocalDateTime date = LocalDateTime.now();
    	DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    	model.addAttribute("id",id);
    	model.addAttribute("panier",panierRepository.findById(id));
    	model.addAttribute("currentDateTime",date.format(formatter).substring(0,16));
    	model.addAttribute("formulaireReservation", new FormulaireReservation());

        return "reserver";
    }
    
    @PostMapping({"/reserver/done"})
    public String reserverDone(@ModelAttribute FormulaireReservation formulaireReservation, Model model) {
    	User u = userRepository.findByUsername(formulaireReservation.getUser());
    	Panier p = panierRepository.findByNom(formulaireReservation.getPanier());
    	String d = formulaireReservation.getDateTime().replace("T", " ");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		LocalDateTime dateTime = LocalDateTime.parse(d, formatter);
		formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy à HH:mm");
		d = dateTime.format(formatter);
		reservationRepository.save(new Reservation(u, p, d));
    	model.addAttribute("formulaireReservation",formulaireReservation);

        return "redirect:/welcome";
    }
    
    @PostMapping({"/mesreservations"})
    public String mesReservations(@ModelAttribute FormulaireReservation formulaireReservation ,Model model) {
    	model.addAttribute("listeReservation",reservationRepository.findAllByUser(userRepository.findByUsername(formulaireReservation.getUser())));
    	return "mesreservations";
    }
    
    @GetMapping({"/annuler/reservation/{id}"})
    public String annulerReservation(@PathVariable("id") long id, Model model) {
    	reservationRepository.deleteById(id);

        return "redirect:/welcome";
    }
    
}