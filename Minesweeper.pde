import de.bezier.guido.*;
private boolean gameOver = false;
private int numMarkedBombs = 0;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons;
private MSButton[][] buttons1;
private MSButton restartbutton; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> ();
private ArrayList <MSButton> bombs1 = new ArrayList <MSButton> ();
 //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(600, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    restartbutton = new MSButton(0, 0);
    restartbutton.x = 420;
    restartbutton.y = 200;
    restartbutton.width = 70;
    restartbutton.height = 15;
    restartbutton.setLabel("RESTART");
    buttons = new MSButton [NUM_ROWS] [NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){

        for(int c = 0; c < NUM_COLS; c++){

            buttons[r][c] = new MSButton(r, c);
        }
    }
    //declare and initialize buttons
    setBombs();


}
public void setBombs()
{
    int x = 0;
    while(x < 50){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col])){
        
            bombs.add(buttons[row][col]);
        }
        
        x++;
    }
    
    
    
    //your code
}

public void draw ()
{
    background( 0 );
    if(isWon()){
        displayWinningMessage();
    }
    for(int x = 0; x< bombs.size(); x++){
        if(bombs.get(x).isMarked()){
            numMarkedBombs+=1;
            noLoop();
        }
    }
    fill(0);
    rect(420,150,50,50);
    fill(255);
    //text(numMarkedBombs, 420, 150);
    text("do not click on bombs, \n do not mark either. Just \n leave them blank and \n move on! :D", 500, 100);

    
    
    
    
    
}
public boolean isWon()
{
    
    for(int i = 0; i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_COLS; j++){
            if(bombs.contains(buttons[i][j].clicked) || !buttons[i][j].clicked){
                return false;
            }
        }
    }
    //your code here
    return true;
}

public void displayLosingMessage()
{
    String loseMessage = "Game over" ;
    fill(255, 0, 0);
    text(loseMessage, 450,150 );
    


    //your code here
}
public void displayWinningMessage()
{
    String winMessage = "You Win";
    fill(255, 0, 0);
    text(winMessage, 450,100 );
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        bombs1 = new ArrayList <MSButton> ();
        if(restartbutton == this){
            for(int r = 0; r < NUM_ROWS; r++){

                for(int c = 0; c < NUM_COLS; c++){

                    
                    buttons[r][c].marked = false;
                    buttons[r][c].clicked = false;
                    buttons[r][c].setLabel("");

                    
                }
            }
            setBombs();

            gameOver = false;
            return;
        }
        if(gameOver == true){
            return;
        }
        if(clicked == false)
           clicked = true;
        else 
            return;
            
        
        if(keyPressed == true){
            marked = !marked; 

        } else if(bombs.contains(this)){
                displayLosingMessage();
                gameOver = true;

        } else if(countBombs(r, c) > 0){
                setLabel(label + countBombs(r, c));
        }  else{
            
            if(isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked()){
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked()){
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r, c+1) && !buttons[r][c+1].isClicked()){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r, c-1) && !buttons[r][c-1].isClicked()){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r+1, c) && !buttons[r+1][c].isClicked()){
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r-1, c) && !buttons[r-1][c].isClicked()){
                buttons[r-1][c].mousePressed();

            }
            if(isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked()){
                buttons[r-1][c+1].mousePressed();

            }
            if(isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked()){
                buttons[r+1][c-1].mousePressed();

            }
            
            
        
            
        }
        //your code here
        
    }

    public void draw () 
    {    
        if (marked){
            fill(0);
            
        }
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
        if(buttons[r][c].isClicked() && bombs.contains(buttons[r][c])){

            displayLosingMessage();
            

        }


        

    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        // if(0 <= r && r <= NUM_ROWS-1 && 0 <= c && c <= NUM_COLS-1){
        //     return true;
            
        // }
        // //your code here
        // return false;
       
            if(r < 0) return false;
            else if(r >= NUM_ROWS) return false;
            else if(c < 0) return false;
            else if(c >= NUM_COLS) return false;
            else return true;
        
     
        

    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        
            
            if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])){
                numBombs++;
            }
            if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])){
                numBombs++;
            }
            if(isValid(row-1, col) && bombs.contains(buttons[row-1][col])){
                numBombs++;
            }  
            if(isValid(row, col-1) && bombs.contains(buttons[row][col-1])){
                numBombs++;
            }    
            if(isValid(row, col+1) && bombs.contains(buttons[row][col+1])){
                numBombs++;
            }
            if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])){
                 numBombs++;
            }
            if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])){
                numBombs++;
            }
            if(isValid(row+1, col) && bombs.contains(buttons[row+1][col])){
                numBombs++;
            }
        
        
        
        
        //your code here
        return numBombs;
        
    }
}
