#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

#define ROWS 6
#define COLS 7

char c4_cur = 'X';
char c4_board[ROWS][COLS];

void init_board() {
    for (int i = 0; i < ROWS; i++)
        for (int j = 0; j < COLS; j++)
            c4_board[i][j] = '.';
}

void print_board() {
    printf("\n 1  2  3  4  5  6  7\n");
    for (int i = 0; i < ROWS; i++) {
        char line[32];
        int p = 0;
        line[p++] = ' ';
        for (int j = 0; j < COLS; j++) {
            line[p++] = c4_board[i][j];
            if (j < COLS - 1) {
                line[p++] = ' ';
            }
            line[p++] = ' ';
        }
        line[p++] = '\n';
        write(1, line, p);
    }
    printf("---------------\n");
}

int get_next_open_row(int col) {
    for (int r = ROWS - 1; r >= 0; r--) {
        if (c4_board[r][col] == '.')
            return r;
    }
    return -1;
}

void make_move(int row, int col, char piece) {
    c4_board[row][col] = piece;
}

void undo_move(int row, int col) {
    c4_board[row][col] = '.';
}

int check_win(char p) {
    // Check Horizontal
    for (int r = 0; r < ROWS; r++)
        for (int c = 0; c < COLS - 3; c++)
            if (c4_board[r][c] == p && c4_board[r][c + 1] == p &&
                c4_board[r][c + 2] == p && c4_board[r][c + 3] == p)
                return 1;

    // Check Vertical
    for (int r = 0; r < ROWS - 3; r++)
        for (int c = 0; c < COLS; c++)
            if (c4_board[r][c] == p && c4_board[r + 1][c] == p &&
                c4_board[r + 2][c] == p && c4_board[r + 3][c] == p)
                return 1;

    // Check Diagonal /
    for (int r = 3; r < ROWS; r++)
        for (int c = 0; c < COLS - 3; c++)
            if (c4_board[r][c] == p && c4_board[r - 1][c + 1] == p &&
                c4_board[r - 2][c + 2] == p && c4_board[r - 3][c + 3] == p)
                return 1;

    // Check Diagonal \ (Backwards)
    for (int r = 0; r < ROWS - 3; r++)
        for (int c = 0; c < COLS - 3; c++)
            if (c4_board[r][c] == p && c4_board[r + 1][c + 1] == p &&
                c4_board[r + 2][c + 2] == p && c4_board[r + 3][c + 3] == p)
                return 1;

    return 0;
}

int is_board_full() {
    for (int c = 0; c < COLS; c++)
        if (get_next_open_row(c) != -1)
            return 0;
    return 1;
}

int score_window(char window[4], char piece) {
    int score = 0;
    char opp = (piece == 'O') ? 'X' : 'O';
    int count_piece = 0, count_empty = 0, count_opp = 0;
    for (int i = 0; i < 4; i++) {
        if (window[i] == piece)
            count_piece++;
        else if (window[i] == opp)
            count_opp++;
        else if (window[i] == '.')
            count_empty++;
    }
    if (count_piece == 4)
        score += 1000;
    else if (count_piece == 3 && count_empty == 1)
        score += 100;
    else if (count_piece == 2 && count_empty == 2)
        score += 10;
    if (count_opp == 3 && count_empty == 1)
        score -= 80;
    return score;
}

int evaluate_position(char piece) {
    int score = 0;
    // center column preference
    int center_count = 0;
    for (int r = 0; r < ROWS; r++)
        if (c4_board[r][COLS / 2] == piece)
            center_count++;
    score += center_count * 6;

    // Horizontal
    for (int r = 0; r < ROWS; r++) {
        for (int c = 0; c < COLS - 3; c++) {
            char window[4];
            for (int k = 0; k < 4; k++)
                window[k] = c4_board[r][c + k];
            score += score_window(window, piece);
        }
    }
    // Vertical
    for (int c = 0; c < COLS; c++) {
        for (int r = 0; r < ROWS - 3; r++) {
            char window[4];
            for (int k = 0; k < 4; k++)
                window[k] = c4_board[r + k][c];
            score += score_window(window, piece);
        }
    }
    // Diagonal
    for (int r = 0; r < ROWS - 3; r++) {
        for (int c = 0; c < COLS - 3; c++) {
            char window[4];
            for (int k = 0; k < 4; k++)
                window[k] = c4_board[r + k][c + k];
            score += score_window(window, piece);
        }
    }
    // Diagonal /
    for (int r = 3; r < ROWS; r++) {
        for (int c = 0; c < COLS - 3; c++) {
            char window[4];
            for (int k = 0; k < 4; k++)
                window[k] = c4_board[r - k][c + k];
            score += score_window(window, piece);
        }
    }
    return score;
}

int minimax(int depth, int alpha, int beta, int maximizingPlayer, int *bestCol) {
    if (check_win('O'))
        return 1000000;
    if (check_win('X'))
        return -1000000;
    if (depth == 0 || is_board_full()) {
        return evaluate_position('O') - evaluate_position('X');
    }

    if (maximizingPlayer) {
        int value = -10000000;
        int localBest = -1;
        for (int c = 0; c < COLS; c++) {
            int r = get_next_open_row(c);
            if (r == -1)
                continue;
            make_move(r, c, 'O');
            int score = minimax(depth - 1, alpha, beta, 0, bestCol);
            undo_move(r, c);
            if (score > value) {
                value = score;
                localBest = c;
            }
            if (value > alpha)
                alpha = value;
            if (alpha >= beta)
                break;
        }
        if (bestCol && localBest != -1)
            *bestCol = localBest;
        return value;
    } else {
        int value = 10000000;
        int localBest = -1;
        for (int c = 0; c < COLS; c++) {
            int r = get_next_open_row(c);
            if (r == -1)
                continue;
            make_move(r, c, 'X');
            int score = minimax(depth - 1, alpha, beta, 1, bestCol);
            undo_move(r, c);
            if (score < value) {
                value = score;
                localBest = c;
            }
            if (value < beta)
                beta = value;
            if (alpha >= beta)
                break;
        }
        if (depth == 0)
            *bestCol = localBest;
        return value;
    }
}

int get_ai_move() {
    int best = 0;
    // depth tuned for speed
    minimax(6, -10000000, 10000000, 1, &best);
    return best;
}

int main(int argc, char *argv[]) {
    if (argc >= 2 && argv[1][0] == '?') {
        printf("c4, optional -ai for ai mode\n");
        return 0;
    }

    // check for ai mode
    int ai_mode = 0;
    for (int i = 1; i < argc; ++i)
        if (strcmp(argv[i], "-ai") == 0) {
            printf("\nGood luck bro, you need it :p\n");
            ai_mode = 1;
            break;
        }

    int playing = 1;
    while (playing) {
        init_board();
        int random_starter = randd() % 2;
        if (random_starter == 0) {
            c4_cur = 'X';
            printf("\nPlayer X starts.\n");
        } else {
            c4_cur = 'O'; // AI (or Player 2)
            printf("\nPlayer O starts.\n");
        }

        char buf[16];
        int col, row;
        while (1) {
            print_board();

            if (ai_mode && c4_cur == 'O') {
                col = get_ai_move();
            } else {
                // printf with %c is unreliable in this environment; write the char directly
                printf("Player ");
                write(1, &c4_cur, 1);
                printf(" (1-7): ");
                int n = read(0, buf, sizeof(buf) - 1);
                if (n <= 0)
                    continue;
                buf[n] = 0;

                // Detect Ctrl-C
                if (buf[n - 1] == '\n')
                    buf[n - 1] = 0;

                if (strcmp(buf, "exit") == 0) {
                    printf("bye...\n");
                    playing = 0;
                    break;
                }

                col = atoi(buf) - 1;
            }

            row = get_next_open_row(col);
            if (row == -1 || col < 0 || col >= COLS) {
                printf("Invalid move!\n");
                continue;
            }

            make_move(row, col, c4_cur);

            if (check_win(c4_cur)) {
                print_board();
                printf("Player ");
                write(1, &c4_cur, 1);
                printf(" Wins!\n");
                break;
            }

            c4_cur = (c4_cur == 'X') ? 'O' : 'X';
        }
    }
    return 0;
}
