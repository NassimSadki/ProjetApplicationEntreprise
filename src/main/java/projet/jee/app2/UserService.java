package projet.jee.app2;


public interface UserService {
    void save(User user);

    User findByUsername(String username);
}