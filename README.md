# RCPSP-CPLEX-MIP-Advanced-Models
**Scalable &amp; Comprehensive MIP** formulations for **RCPSP** using **CPLEX/OPL**. Includes Classic, **TVM**, and advanced **Multi-Mode (MM)** models with Dual Resources (R/NR) &amp; **Mode Grouping** logic. Focuses on combinatorial optimization mastery and designed to scale seamlessly to **Multi-Project (MP)** and portfolio optimization problems.

# RCPSP-CPLEX-MIP-Advanced-Models: Comprehensive Scheduling Formulations

## 🌟 Project Overview

This repository features advanced **Mixed-Integer Programming (MIP)** formulations for the **Resource-Constrained Project Scheduling Problem (RCPSP)**, implemented and solved using the **IBM ILOG CPLEX Optimization Studio**.

The models are developed to showcase high proficiency in combinatorial optimization modeling by extending the classic RCPSP to include critical real-world complexities. These foundational models are **Scalable** and designed to seamlessly integrate with future developments in **Multi-Project (MP)** and portfolio optimization.

## 🛠️ Model Implementations and Features

### 1. Classic RCPSP Model (Minimize Makespan)

* **File:** `/Classic_RCPSP/RCPSP_Classic_MIP.mod`
* **Objective:** Minimizing the project completion time (Makespan).
* **Key Feature:** The standard, time-indexed formulation establishing the core structure.

### 2. RCPSP with Time Value of Money (TVM)

* **File:** `/TVM_RCPSP/RCPSP_TVM_MIP.mod`
* **Objective:** **Minimize the Net Present Value (NPV)** of total project costs.
* **Key Feature:** Integration of dynamic financial constraints (Interest and Inflation Rates) and calculation of the **Time Value Effect** via OPL's `execute` block. This model optimizes financial value, not just time.

### 3. Multi-Mode RCPSP with Grouping (RCPSP-MM)

* **File:** `/MM_RCPSP/RCPSP_MM_MIP.mod`
* **Objective:** Minimize Makespan (default).
* **Complexity Highlights:**
    * **Dual Resource Handling:** Correct handling of **Renewable** (R) and **Non-Renewable** (NR) resources, utilizing `ExecutionIndicator` for R and `StartIndicator` for NR.
    * **Mode Selection:** Allows flexible processing via multiple modes per activity.
    * **Mode Grouping:** Implementation of advanced constraints to enforce a global strategic selection of the active mode group.

### 4. Future Roadmap

The structure is ready for the integration of **Multi-Project Scheduling (MPS)** models and their variants (MPS-TVM, MPS-MM), demonstrating a plan for scaling to portfolio optimization.

## ⚙️ Technical Mastery and Utilities

* **Modeling Language:** OPL (Optimization Programming Language)
* **Solver:** IBM ILOG CPLEX Optimization Studio
* **Advanced Debugging:** Utilization of **`cplex.refineConflict()`** for effective analysis and diagnosis of model infeasibilities in complex MIPs.
* **Model Validation:** All models rely on robust, time-indexed binary variables for exact optimal solutions.
* **Author:** Ali Atabaki

## 📁 Repository Structure

| Directory | Content Description |
| :--- | :--- |
| **`/Classic_RCPSP`** | OPL model and data for the standard RCPSP. |
| **`/TVM_RCPSP`** | OPL model and data incorporating financial (TVM) constraints. |
| **`/MM_RCPSP`** | OPL model and data for the complex Multi-Mode/Dual Resource variant. |
| **`/Documentation`** | Contains the detailed mathematical formulations (PDF/LaTeX). |
| **`/Data_Sets`** | Standard and custom data instances for testing. |
