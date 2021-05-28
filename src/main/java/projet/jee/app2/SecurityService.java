package projet.jee.app2;
public interface SecurityService {
    String findLoggedInUsername();

    void autoLogin(String username, String password);
}