/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pl.java.blog.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import pl.java.blog.entities.Account;
import pl.java.blog.entities.Post;

/**
 *
 * @author pawko
 */
@Stateless
public class BlogEjb {

    @PersistenceContext(unitName = "persistence")
    EntityManager entityManager;

    public void addAccount(Account account) {
        entityManager.merge(account);
    }

    public void addPost(Post post) {
        entityManager.merge(post);
    }

    public void deletePostById(int id) {
        Post post = entityManager.find(Post.class, id);
        entityManager.remove(post);
    }

    public Post getPostById(int id) {
        Post post = entityManager.find(Post.class, id);
        return post;
    }

    public Account getAcoount(String login, String password) {
        Query q = entityManager.createQuery("Select a from Account a WHERE a.login = :login AND a.password = :password");
        q.setParameter("login", login);
        q.setParameter("password", password);
        if (q.getResultList().isEmpty()) {
            return null;
        }
        Account account = (Account) q.getResultList().get(0);
        return account;
    }

    public Account getAcoount(String login) {
        Query q = entityManager.createQuery("Select a from Account a WHERE a.login = :login");
        q.setParameter("login", login);
        if (q.getResultList().isEmpty()) {
            return null;
        }
        Account account = (Account) q.getResultList().get(0);
        return account;
    }

    public List<Post> getAllPosts() {
        Query q = entityManager.createQuery("Select p from Post p ORDER BY p.postDate DESC");
        List<Post> listOfPosts = q.getResultList();
        return listOfPosts;
    }

}
