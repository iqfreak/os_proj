#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

#define B 3

char board[B][B];
char cur = 'X';

void init_board(void) {
    for (int i = 0; i < B; i++)
        for (int j = 0; j < B; j++)
            board[i][j] = '1' + i * B + j;
}

void out(const char *s, int len) { write(1, s, len); }

void draw_board(void) {
    out("\n=== TIC TAC TOE ===\n\n", 21);
    for (int i = 0; i < B; i++) {
        char line[16];
        int p = 0;
        line[p++] = board[i][0];
        line[p++] = ' ';
        line[p++] = '|';
        line[p++] = ' ';
        line[p++] = board[i][1];
        line[p++] = ' ';
        line[p++] = '|';
        line[p++] = ' ';
        line[p++] = board[i][2];
        line[p++] = '\n';
        out(line, p);
        if (i < B - 1)
            out("--+---+--\n", 10);
    }
    out("\n", 1);
}

int win(void) {
    for (int i = 0; i < B; i++)
        if (board[i][0] == board[i][1] && board[i][1] == board[i][2])
            return 1;
    for (int j = 0; j < B; j++)
        if (board[0][j] == board[1][j] && board[1][j] == board[2][j])
            return 1;
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2])
        return 1;
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0])
        return 1;
    return 0;
}

int draw(void) {
    for (int i = 0; i < B; i++)
        for (int j = 0; j < B; j++)
            if (board[i][j] >= '1' && board[i][j] <= '9')
                return 0;
    return 1;
}

int make_move(int pos) {
    if (pos < 1 || pos > 9)
        return 0;
    int r = (pos - 1) / B, c = (pos - 1) % B;
    if (board[r][c] == 'X' || board[r][c] == 'O')
        return 0;
    board[r][c] = cur;
    return 1;
}

int simple_atoi(const char *s) {
    int n = 0;
    while (*s && (*s < '0' || *s > '9'))
        s++;
    if (!*s)
        return 0;
    while (*s >= '0' && *s <= '9') {
        n = n * 10 + (*s - '0');
        s++;
    }
    return n;
}

void prompt_player(void) {
    out("Player ", 7);
    write(1, &cur, 1);
    out(", choose (1-9): ", 17);
}

// ============= AI Stuff ==============

int evaluate_board() {
    // Check Rows for a win
    for (int i = 0; i < B; i++) {
        if (board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
            if (board[i][0] == 'O')
                return 10;
            else if (board[i][0] == 'X')
                return -10;
        }
    }

    // Check Columns for a win (THIS WAS MISSING)
    for (int j = 0; j < B; j++) {
        if (board[0][j] == board[1][j] && board[1][j] == board[2][j]) {
            if (board[0][j] == 'O')
                return 10;
            else if (board[0][j] == 'X')
                return -10;
        }
    }

    // Check Diagonals for a win (THIS WAS MISSING)
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
        if (board[0][0] == 'O')
            return 10;
        else if (board[0][0] == 'X')
            return -10;
    }

    if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
        if (board[0][2] == 'O')
            return 10;
        else if (board[0][2] == 'X')
            return -10;
    }

    return 0;
}

// AI is MAX, always O
int minimax(int depth, int isMax, int alpha, int beta, int *bestMove) {
    int score = evaluate_board();

    if (score == 10)
        return score - depth;
    if (score == -10)
        return score + depth;
    if (draw())
        return 0;

    int localBestMove = -1;
    int best;

    if (isMax) {
        best = -10000;
        for (int i = 0; i < B; i++) {
            for (int j = 0; j < B; j++) {
                if (board[i][j] != 'X' && board[i][j] != 'O') {

                    char backup = board[i][j];
                    board[i][j] = 'O';

                    int val = minimax(depth + 1, 0, alpha, beta, bestMove);

                    board[i][j] = backup;

                    if (val > best) {
                        localBestMove = (i * 3 + 1 + j);
                        best = val;
                    }

                    if (best > alpha) {
                        alpha = best;
                    }
                    if (beta <= alpha) {
                        break;
                    }
                }
            }

            if (beta <= alpha)
                break;
        }
    } else {
        best = 10000;
        for (int i = 0; i < B; i++) {
            for (int j = 0; j < B; j++) {
                if (board[i][j] != 'X' && board[i][j] != 'O') {

                    char backup = board[i][j];
                    board[i][j] = 'X';

                    int val = minimax(depth + 1, 1, alpha, beta, bestMove);

                    board[i][j] = backup;

                    if (val < best) {
                        localBestMove = (i * 3 + 1 + j);
                        best = val;
                    }

                    if (best < beta) {
                        beta = best;
                    }
                    if (beta <= alpha) {
                        break;
                    }
                }
            }

            if (beta <= alpha)
                break;
        }
    }

    if (depth == 0)
        *bestMove = localBestMove;

    return best;
}
int main(int argc, char *argv[]) {
    if (argc >= 2 && argv[1][0] == '?') {
        printf("xo, optional -ai for ai mode\n");
        return 0;
    }

    init_board();
    int ai_mode = 0;
    for (int i = 1; i < argc; ++i)
        if (strcmp(argv[i], "-ai") == 0) {
            printf("\nGet Ready To Lose Bud >:P\n");
            ai_mode = 1;
            break;
        }

    char buf[16];
    int random_starter = randd() % 2;
    if (random_starter == 0) {
        cur = 'X';
        printf("\nPlayer X starts.\n");
    } else {
        cur = 'O'; // AI (or Player 2)
        printf("\nPlayer O starts.\n");
    }

    while (1) {
        draw_board();

        int pos;
        if (ai_mode && cur == 'O') {
            minimax(0, 1, -1000000, 1000000, &pos);
        } else {
            prompt_player();

            int n = read(0, buf, sizeof(buf) - 1);
            if (n <= 0)
                continue;
            buf[n] = 0;

            pos = simple_atoi(buf);
        }
        if (!make_move(pos)) {
            printf("Invalid move at %d. Try again.\n", pos);
            continue;
        }

        if (win()) {
            draw_board();
            out("Player ", 7);
            write(1, &cur, 1);
            out(" wins!\n", 7);
            break;
        }

        if (draw()) {
            draw_board();
            out("It's a draw!\n", 13);
            break;
        }

        cur = (cur == 'X') ? 'O' : 'X';
    }
    if (ai_mode)
        printf("told ya you can't win >:P\n");

    out("Game over.\n", 11);
    exit(0);
}
