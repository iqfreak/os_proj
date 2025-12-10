#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define B 3

char board[B][B];
char cur = 'X';


void init_board(void) {
  for(int i=0;i<B;i++) for(int j=0;j<B;j++) board[i][j] = '1' + i*B + j;
}


void out(const char *s, int len) { write(1, s, len); }

void draw_board(void) {
  out("\n=== TIC TAC TOE ===\n\n", 21);
  for(int i=0;i<B;i++){
    char line[16];
    int p = 0;
    line[p++] = board[i][0];
    line[p++] = ' '; line[p++] = '|'; line[p++] = ' ';
    line[p++] = board[i][1];
    line[p++] = ' '; line[p++] = '|'; line[p++] = ' ';
    line[p++] = board[i][2];
    line[p++] = '\n';
    out(line, p);
    if(i < B-1) out("--+---+--\n", 10);
  }
  out("\n",1);
}


int win(void) {
  for(int i=0;i<B;i++) if(board[i][0]==board[i][1] && board[i][1]==board[i][2]) return 1;
  for(int j=0;j<B;j++) if(board[0][j]==board[1][j] && board[1][j]==board[2][j]) return 1;
  if(board[0][0]==board[1][1] && board[1][1]==board[2][2]) return 1;
  if(board[0][2]==board[1][1] && board[1][1]==board[2][0]) return 1;
  return 0;
}

int draw(void) {
  for(int i=0;i<B;i++) for(int j=0;j<B;j++)
  if(board[i][j] >= '1' && board[i][j] <= '9') return 0;
  return 1;
}


int make_move(int pos) {
  if(pos < 1 || pos > 9) return 0;
  int r = (pos-1)/B, c = (pos-1)%B;
  if(board[r][c]=='X' || board[r][c]=='O') return 0;
  board[r][c] = cur;
  return 1;
}


int simple_atoi(const char *s){
  int n=0;
  while(*s && (*s < '0' || *s > '9')) s++;
  if(!*s) return 0;
  while(*s >= '0' && *s <= '9'){ n = n*10 + (*s - '0'); s++; }
  return n;
}


void prompt_player(void){
  out("Player ", 7);
  write(1, &cur, 1);
  out(", choose (1-9): ", 17);
}

int main(void) {
  init_board();
  while(1) {
    draw_board();
    prompt_player();

    char buf[16];
    int n = read(0, buf, sizeof(buf)-1);
    if(n <= 0) continue;
    buf[n] = 0;

    int pos = simple_atoi(buf);
    if(!make_move(pos)) {
      out("Invalid move. Try again.\n", 24);
      continue;
    }

    if(win()) {
      draw_board();
      out("Player ", 7); write(1, &cur, 1); out(" wins!\n", 7);
      break;
    }

    if(draw()) {
      draw_board();
      out("It's a draw!\n", 13);
      break;
    }

    cur = (cur == 'X') ? 'O' : 'X';
  }

  out("Game over.\n", 11);
  exit(0);
}
