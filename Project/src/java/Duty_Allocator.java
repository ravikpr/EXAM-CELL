
import java.util.Random;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author p
 */
public class Duty_Allocator {
    /** Generate 10 random integers in the range 0..99. */
  
    public static String[] ran_num(String fac_id[],int length)
    {
        //array to store N random integers (0 - N-1)
        //int[] fac_id = new int[no_of_fac];

        // initialize each value at index i to the value i 
        /*for (int i = 0; i < fac_id.length; ++i)
        {
            fac_id[i] = i;
        }
*/
        Random randomGenerator = new Random();
        int randomIndex; // the randomly selected index each time through the loop
        String randomValue; // the value at fac_id[randomIndex] each time through the loop

        // randomize order of values
        for(int i = 0; i <length; ++i)
        {
             // select a random index
             randomIndex = randomGenerator.nextInt(length);
             // swap values
             randomValue = fac_id[randomIndex];
             fac_id[randomIndex] = fac_id[i];
             fac_id[i] = randomValue;
        }
        System.out.println("fac_id length is "+length);
        for(int i = 0; i < length; ++i)
        {
            
            System.out.print(fac_id[i]+"\t");
        }
        System.out.println("");
        return fac_id;
}
}
 
    

