/*********************************************
 * OPL RCPSP Single-Mode Model
 * Author: Ali Atabaki
 * Description: Resource-Constrained Project Scheduling Problem
 *              with renewable resources and precedence constraints
 *********************************************/

/* -----------------------------
   Problem dimensions and ranges
   ----------------------------- */
int nActivities = ...;   // number of activities
int nResources  = ...;   // number of renewable resources
int Horizon     = ...;   // planning horizon

range Activities = 1..nActivities;
range Resources  = 1..nResources;
range Times      = 1..Horizon;

/* -----------------------------
   Input parameters
   ----------------------------- */
int Duration[i in Activities] = ...; // duration of each activity
int ResourceRequirement[i in Activities][k in Resources] = ...; // resource demand per activity
int ResourceCapacity[k in Resources] = ...; // total capacity per resource
int PrecedenceRelation[j in Activities][i in Activities] = ...; // precedence matrix (1 if j precedes i)

/* -----------------------------
   Derived parameters (computed in execute block)
   ----------------------------- */
int LatestStartTime[i in Activities]; // latest feasible start time for activity i
int ValidStartLeadingToFinishAt[t in Times][i in Activities]; // valid start times that contribute to execution at time t
int FinishTimeIfStartAt[t in Times][i in Activities]; // finish time if activity i starts at time t

execute {
  for (var i in Activities)
    LatestStartTime[i] = Horizon - Duration[i] + 1;

  for (var t in Times)
    for (var i in Activities)
      ValidStartLeadingToFinishAt[t][i] = Math.max(1, t - Duration[i] + 1);

  for (var t in Times)
    for (var i in Activities)
      FinishTimeIfStartAt[t][i] = t + Duration[i] - 1;
}

/* -----------------------------
   Decision variables
   ----------------------------- */
dvar boolean StartIndicator[i in Activities][t in Times];     // 1 if activity i starts at time t
dvar boolean ExecutionIndicator[i in Activities][t in Times]; // 1 if activity i is executing at time t
dvar int+ ProjectMakespan;                                    // total project duration

/* -----------------------------
   Objective function
   ----------------------------- */
minimize ProjectMakespan;

/* -----------------------------
   Constraints
   ----------------------------- */
subject to {

  // Each activity must start exactly once at a valid time
  forall(i in Activities)
    sum(t in Times : t <= LatestStartTime[i]) StartIndicator[i][t] == 1;

  // Execution indicator: activity i is executing at time t if it started within its duration window
  forall(i in Activities, t in Times)
    ExecutionIndicator[i][t] ==
      sum(ta in Times : ta >= ValidStartLeadingToFinishAt[t][i] && ta <= t) StartIndicator[i][ta];

  // Precedence constraints: activity i cannot start before j finishes
  forall(j in Activities, i in Activities : PrecedenceRelation[j][i] == 1)
    sum(t in Times) t * StartIndicator[i][t] >=
    sum(t in Times) (t + Duration[j]) * StartIndicator[j][t];

  // Resource constraints: total demand at time t must not exceed capacity
  forall(k in Resources, t in Times)
    sum(i in Activities) ResourceRequirement[i][k] * ExecutionIndicator[i][t] <= ResourceCapacity[k];

  // Makespan must be at least the finish time of each activity
  forall(i in Activities)
    ProjectMakespan >= sum(t in Times) FinishTimeIfStartAt[t][i] * StartIndicator[i][t];
}

/* -----------------------------
   Output block (CSV format)
   ----------------------------- */
execute {
  writeln("======================================");
  writeln("   Solution to Simple RCPSP Instance  ");
  writeln("======================================\n \n");
  writeln("** ProjectMakespan=   ", ProjectMakespan,"\n");
  for (var i in Activities){
    for (var t in Times){
      if (StartIndicator[i][t]==1) {
        var dur = Duration[i];
        var finish = t + dur - 1;
        writeln( "*X[",i,",",t, "] =1  ,,, Activity ",i,"  Start at ",t,"  for duration : ", dur, "   finish at :", finish);
      }
      
      
        if (ExecutionIndicator[i][t]==1) {
       
        writeln( "	.Y[",i,",",t, "] =1  ,,, Activity ",i,"  is Active in ",t);
      }
}writeln(); }}
