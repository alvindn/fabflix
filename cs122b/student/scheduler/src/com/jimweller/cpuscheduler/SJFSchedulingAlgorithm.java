/** SJFSchedulingAlgorithm.java
 * 
 * A shortest job first scheduling algorithm.
 *
 * @author: Charles Zhu
 * Spring 2016
 *
 */
package com.jimweller.cpuscheduler;

import java.util.*;

import com.jimweller.cpuscheduler.Process;

public class SJFSchedulingAlgorithm extends BaseSchedulingAlgorithm implements OptionallyPreemptiveSchedulingAlgorithm {

    private LinkedHashMap<Process,Long> currentJobs;
    private boolean preemptive;
    SJFSchedulingAlgorithm(){
        // Fill in this method
        /*------------------------------------------------------------*/
        currentJobs = new LinkedHashMap<Process,Long>();
        preemptive = false;


        /*------------------------------------------------------------*/
    }

    /** Add the new job to the correct queue.*/
    public void addJob(Process p){
        // Remove the next lines to start your implementation
        
        // Fill in this method
        /*------------------------------------------------------------*/
        currentJobs.put(p,p.burst);


        /*------------------------------------------------------------*/
    }

    
    /** Returns true if the job was present and was removed. */
    public boolean removeJob(Process p){
        // Remove the next lines to start your implementation
        
        // Fill in this method
        /*------------------------------------------------------------*/
        if(currentJobs.containsKey(p)) {
            currentJobs.remove(p);
            return true;
        }
        return false;


        /*------------------------------------------------------------*/
    }

    /** Transfer all the jobs in the queue of a SchedulingAlgorithm to another, such as
    when switching to another algorithm in the GUI */
    public void transferJobsTo(SchedulingAlgorithm otherAlg) {
        throw new UnsupportedOperationException();
    }

    /** Returns the next process that should be run by the CPU, null if none available.*/
    public Process getNextJob(long currentTime){
        // Remove the next lines to start your implementation
        
        // Fill in this method
        /*------------------------------------------------------------*/
        if(currentJobs.size() > 0) {
            if(preemptive) {

            }
            else {

            }
        }
        else {
            return null;
        }


        /*------------------------------------------------------------*/
    }

    public String getName(){
        return "Shortest Job First";
    }

    /**
     * @return Value of preemptive.
     */
    public boolean isPreemptive(){
        // Remove the next lines to start your implementation
        
        // Fill in this method
        /*------------------------------------------------------------*/
        return preemptive;


        /*------------------------------------------------------------*/
    }
    
    /**
     * @param v  Value to assign to preemptive.
     */
    public void setPreemptive(boolean  v){
        // Remove the next lines to start your implementation
        
        // Fill in this method
        /*------------------------------------------------------------*/
        preemptive = v;


        /*------------------------------------------------------------*/
    }
    
}