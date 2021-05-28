package projet.jee.app2;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
	List<Reservation> findAllByUser(User user);
	@Transactional
	void deleteByPanier(Panier panier);
}
