package com.example.ejb;

import com.example.rmi.model.Account;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Stateless
public class EnhancedBankingTimerService {
    @PersistenceContext(unitName = "bankPU")
    private EntityManager entityManager;

    @Schedule(hour = "2", minute = "0", second = "0", persistent = true,
             info = "DailyInterestCalculation", timezone = "Asia/Colombo")
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void calculateDailyInterest() {
        try {
            List<Account> savingsAccounts = entityManager.createQuery(
                "SELECT a FROM Account a WHERE a.accountType = 'SAVINGS' AND a.status = 'ACTIVE'",
                Account.class).getResultList();

            for (Account account : savingsAccounts) {
                BigDecimal dailyInterestRate = new BigDecimal("0.03")
                    .divide(new BigDecimal("365"), 6, RoundingMode.HALF_UP);
                BigDecimal interestAmount = account.getBalance()
                    .multiply(dailyInterestRate)
                    .setScale(2, RoundingMode.HALF_UP);

                account.setBalance(account.getBalance().add(interestAmount));
                entityManager.merge(account);
            }
        } catch (Exception e) {
            // Log error and trigger retry mechanism
            throw new EJBException("Interest calculation failed: " + e.getMessage());
        }
    }
}
