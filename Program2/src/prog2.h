#pragma once
#include <vector>

class Stmt {
        virtual ~Stmt() {}
};

class Stmts : public Stmt {
public:
        void push_back(Stmt * stmt) {
                v.push_back(stmt);
        }
private:
        std::vector<Stmt *> v;
};

class Loop : public Stmt {
        Loop(Stmts &s) : ss(s) {}
private:
        Stmts ss;
};

class Decptr : public Stmt {};

class Incptr : public Stmt {};

class Decdata : public Stmt {};

class Incdata : public Stmt {};

class Putchar : public Stmt {};

class Getchar : public Stmt {};

