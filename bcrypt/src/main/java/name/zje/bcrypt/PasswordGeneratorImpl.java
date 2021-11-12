package name.zje.bcrypt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordGeneratorImpl implements PasswordGenerator {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public String generatePassword(String password) {
        return passwordEncoder.encode(password);
    }


}
