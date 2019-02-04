package id.co.mandiri.utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SessionFactoryUtils {

    @Autowired
    private SessionFactory sesssionFactory;

    public Session getSesssionFactory() {
        return sesssionFactory.getCurrentSession();
    }
}
