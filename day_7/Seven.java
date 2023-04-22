import java.util.ArrayList;
import java.util.HashMap;
import java .io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Seven {
    public static void main(String[] arg){
        final String FILE_NAME = "input.txt";
        // String currentDIr = "";
        String whole_path= "";
        Node nodeObj = new Node("/");
        try {
            File myObj = new File(FILE_NAME);
            Scanner myReader = new Scanner(myObj);
            while(myReader.hasNextLine()){
                String data = myReader.nextLine();
                Pattern filePattern = Pattern.compile("\\d+ [a-zA-Z].?");
                Pattern dirPattern = Pattern.compile("dir ");
                Pattern chDirPattern = Pattern.compile("\\$ cd");
                if(chDirPattern.matcher(data).find()){

                    String[] splitParts = data.split(" ");
                    if(splitParts.length > 2){
                        // extract the cd part
                        String action = splitParts[2];
                        if(action.matches("..")){
                            int endIndex = whole_path.lastIndexOf("-");
                            whole_path = whole_path.substring(0, endIndex);
                        }else{
                            int actionCharCode  = (int) action.charAt(0);
                            if(actionCharCode == 47){
                                whole_path += action;
                            }else{
                                whole_path += "-"+action;
                            }
                        }
                    }
                }else if(dirPattern.matcher(data).find()){
                    String dirName = data.split(" ")[1];
                    nodeObj.addChildByURL(whole_path+"-"+dirName, new Node(dirName));;
                }else if(filePattern.matcher(data).find()){
                    String[] splitArray = data.split(" ");
                    String fileName = splitArray[1];
                    int fileSize = Integer.parseInt(splitArray[0]);
                    nodeObj.addChildByURL(whole_path+"-"+fileName, new Node(fileName, fileSize));
                }
            }
            myReader.close();
            nodeObj.printDir(0);
            System.out.println(String.format("Total Size %d", nodeObj.getTotalSize(100000, "/")));
        } catch(FileNotFoundException e){
            System.out.println("Error in Reading File");
            e.printStackTrace();
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println("Error Occur");
            e.printStackTrace();
        }
    }
}


class Node{
    private final String folderName;
    private int fileSize = -1;
    HashMap<String, Node> children = new HashMap<String, Node>();

    // For initilizing folder object
    public Node(String folderName){
        this.folderName = folderName;
    }

    // For initilizing file object
    public Node(String folderName, int fileSize){
        this.folderName = folderName;
        this.fileSize = fileSize;
    }

    // getters
    public String getName(){
        return this.folderName;
    }

    public int getSize(){
        return this.fileSize;
    }

    public boolean isFile(){
        return this.fileSize > -1;
    }

    public String getDetails(){
        if(this.isFile()){
            return String.format("|File %s size(%d)",  this.getName(),this.fileSize);
        }else{
            return String.format("|Dir %s", this.getName());
        }
    }

    public void printDir(int tabLevel){
        String tab = "";
        for(int i=0; i<= tabLevel; i++){
            tab += "--";
        }
        System.out.println(tab+this.getDetails());
        for(String i: children.keySet()){
            children.get(i).printDir(tabLevel+1);
        }
    }

    public void addChild(Node child){
        if(this.isFile()){
            final String ANSI_RED = "\u001B[31m";
            System.out.println(ANSI_RED+"Warning Adding Child in File");
        }
        this.children.put(child.getName(), child);
    }

    public void addChildByURL(String url, Node child){
        String path = url;
        path = path.replace("/-", "");
        int indexDot = path.indexOf('-');
        if(indexDot == -1){
            // TODO add child
            System.out.println(String.format("Adding child for parent %s url %s and child %s", this.getName(), url,child.getName() ));
            children.put(child.getName(), child);
        }else{
            String new_path = path.substring(indexDot+1, path.length());
            String key = path.substring(0, indexDot);
            this.children.get(key).addChildByURL(new_path, child);
        }
    }

    

    public int getTotalSize(){
        int total = 0;
        if(this.isFile()){
            return this.fileSize;
        }
        for(String i: children.keySet()){
            total += children.get(i).getTotalSize();
        }
        return total;
    }

    public int getTotalSize(int limit, String path){
        int total = 0;
        if(this.isFile()){
            return this.fileSize;
        }
        for(String i: children.keySet()){
            int total_return =   children.get(i).getTotalSize(limit, path+"-"+i);
            if(total_return >= limit){
                System.out.println(path+" "+total_return);
            }else{
                total += total_return;
            }
        }
        return total;
    }
}

